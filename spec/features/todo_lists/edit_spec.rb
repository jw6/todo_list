require 'spec_helper'

describe "Edit todo lists" do
  def update_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "This is my todo list"

    todo_list = options[:todo_list]

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end


  it "updates a todo list successfully with correct information" do
    todo_list = TodoList.create(title: "Groceries", description: "Grocery list.")

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: "New title"
    fill_in "Description", with: "New description"
    click_button "Update Todo list"

    todo_list.reload

    expect(page).to have_content "Todo list was successfully updated"
    expect(todo_list.title).to eq("New title")
    expect(todo_list.title).to eq("New description")
  end
end

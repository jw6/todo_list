require 'spec_helper'

describe "Creating todo lists" do
  def create_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "This is my todo list"

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"

  end

  it "redirect to the todo list index page on success" do
    create_todo_list

    #expect this page to have content as above
    expect(page).to have_content("My todo list")
  end

  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is my daily todo list.")
  end

  it "displays an error when the todo list has a title less than 3 characters" do
    expect(TodoList.count).to eq(0)
    create_todo_list title: "Hi"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is my daily todo list.")
  end

  it "displays an error when the todo list has no content" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "Shopping", description: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Sams shopping")
  end

  it "displays an error when the description has less than 5 characters" do
    # expect(TodoList.count).to eq(0)

    # visit "/todo_lists"
    # click_link "New Todo list"
    # expect(page).to have_content("New Todo List")

    # fill_in "Title", with: "Sams shopping"
    # fill_in "Description", with: "fool"
    # click_button "Create Todo list"

    # expect(page).to have_content("error")
    # expect(TodoList.count).to eq(0)

    # visit "/todo_lists"
    # expect(page).to_not have_content("Sams shopping")

    expect(TodoList.count). to eq(0)
    create_todo_list title: "Buy something", description:"fool"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Buy something")
  end

end

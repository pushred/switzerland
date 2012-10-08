Feature: Manage Content

    As a writer,
    I want to manage my content with files and folders
    So that I can use my own software for writing

    Scenario: Images

        Given a folder containing images
        When I publish content
        Then the images will be included

    Scenario: Folders

        Given a tree of folders
        When I publish content
        Then that tree will be preserved
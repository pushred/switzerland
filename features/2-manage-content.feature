Feature: Manage Content

    As a writer,
    I want to manage my content with files & folders
    So that I can use my own software for writing

    Scenario: Support image “attachments”

        Given a folder containing image files
        When I publish content
        Then the images will be included

    Scenario: Preserve folder structure

        Given a tree of folders
        When I publish content
        Then that tree will be preserved
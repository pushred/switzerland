Feature: Publishing Content
    As a writer,
    I want to publish my content
    So I can access and present it

    Scenario: Prepare destination

      Given a tree of folders
        When I publish content
        Then the destination will be created if it does not exist
        And any contents will be emptied
        Then that tree will be published into the destination

    Scenario: Specify a different destination

      Given a tree of folders
        When I publish content with a specified destination
        Then the destination will be created if it does not exist
        Then that tree will be published into the destination
        And the destination will match the specified destination
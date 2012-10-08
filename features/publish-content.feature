Feature: Publishing Content
    As a writer,
    I want to publish my content
    So I can access and present it

    Scenario: Clear destination to sync contents

      Given a tree of folders
        When I publish content
        Then the contents of the publishing destination will be emptied
        Then that tree will be published into the destination
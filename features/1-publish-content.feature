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

    Scenario: Provide content as JSON

      Given a folder containing Markdown files with content such as this:
        """
        The overriding design goal for Markdown’s formatting syntax is to make it as readable as possible. The idea is that a Markdown-formatted document should be publishable as-is, as plain text, without looking like it’s been marked up with tags or formatting instructions. While Markdown’s syntax has been influenced by several existing text-to-HTML filters, the single biggest source of inspiration for Markdown’s syntax is the format of plain text email.
        """
      When I publish content
      Then the content will be published as JSON
Feature: Markdown Formatting
    As a writer,
    I want to format my content using Markdown
    So I can better focus on what I’m saying

    Scenario: Parsing

      Given a folder containing Markdown files with content such as this:
        """
        A First Level Header
        ====================

        A Second Level Header
        ---------------------

        Now is the time for all good men to come to
        the aid of their country. This is just a
        regular paragraph.

        The quick brown fox jumped over the lazy
        dog’s back.

        ### Header 3

        > This is a blockquote.
        >
        > This is the second paragraph in the blockquote.
        >
        > ## This is an H2 in a blockquote
        """
      When I publish content
      Then the Markdown will be converted into HTML
Feature: Content Formatting
    As a writer,
    I want to format my content using Markdown and YAML
    So I can better focus on what I’m saying

    Scenario: Markdown Formatting

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

    Scenario: YAML Front Matter

      Given a folder containing files with Markdown and YAML content such as this:
        """
        ---
        layout: three-column
        title: This is an example
        ---

        A Second Level Header
        ---------------------

        Now is the time for all good men to come to
        the aid of their country. This is just a
        regular paragraph.
        """
      When I publish content
      Then the content will be published as JSON

    Scenario: Table of Contents

      Given Markdown containing headings such as this:
        """
        A First Level Header
        ====================

        A Second Level Header
        ---------------------

        ### Header 3
        """
      When I publish content
      Then the Markdown will be converted into HTML
      And each heading will be assigned a unique anchor
      And the anchors will be published as JSON
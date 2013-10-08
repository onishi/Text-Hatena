# NAME

Text::Hatena - The new "Text-to-HTML converter" with Hatena syntax.

# SYNOPSIS

    use Text::Hatena;

    my $parser = Text::Hatena->new;
    my $html = $parser->parse($string);

    # Text::Hatena 0.16 style
    my $html = $parser->html;

    # Text::Hatena 0.20 style
    my $html = Text::Hatena->parse($string);

    # Text::Xatena style
    my $html = $parser->format($string);

# DESCRIPTION

Text::Hatena is a text-to-html converter.

# SYNTAX





# AUTHOR

["cho45 <cho45@lowreal.net>"](#cho45 <cho45@lowreal.net>)

["onishi <yasuhiro.onishi@gmail.com>"](#onishi <yasuhiro.onishi@gmail.com>)

# SEE ALSO

[Text::Xatena](http://search.cpan.org/perldoc?Text::Xatena)

[http://hatenadiary.g.hatena.ne.jp/keyword/%E3%81%AF%E3%81%A6%E3%81%AA%E8%A8%98%E6%B3%95%E4%B8%80%E8%A6%A7](http://hatenadiary.g.hatena.ne.jp/keyword/%E3%81%AF%E3%81%A6%E3%81%AA%E8%A8%98%E6%B3%95%E4%B8%80%E8%A6%A7)

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

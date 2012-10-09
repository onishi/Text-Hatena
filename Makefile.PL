use inc::Module::Install;
name 'Text-Hatena';
all_from 'lib/Text/Hatena.pm';

requires 'Any::Moose';
requires 'Cache::MemoryCache';
requires 'Carp';
requires 'Digest::SHA1';
requires 'Encode';
requires 'Exporter';
requires 'Exporter::Lite';
requires 'HTML::Entities';
requires 'HTML::Parser';
requires 'HTML::Tagset';
requires 'HTTP::Request';
requires 'JSON::XS';
requires 'LWP::UserAgent';
requires 'List::MoreUtils';
requires 'Regexp::Assemble';
requires 'Text::MicroTemplate';
requires 'Text::VimColor';
requires 'UNIVERSAL::require';
requires 'URI::Escape';
requires 'Web::oEmbed';
requires 'Class::Accessor::Fast';
requires 'Class::Accessor::Lvalue::Fast';

tests 't/*.t';
author_tests 'xt';

test_requires 'AnyEvent::HTTP';
test_requires 'Data::Dumper';
test_requires 'Guard';
test_requires 'HTTP::Message::PSGI';
test_requires 'HTTP::Response';
test_requires 'HTTP::Server::PSGI';
test_requires 'LWP::Protocol::PSGI';
test_requires 'LWP::Protocol';
test_requires 'Plack::Request';
test_requires 'Scalar::Util';
test_requires 'URI';
test_requires 'Test::More';
test_requires 'Test::Most';
test_requires 'Test::Name::FromLine';
test_requires 'Test::TCP';

auto_set_repository;
auto_include;
WriteAll;

#!/usr/bin/ruby -w
# -*- coding : utf-8 -*-

content = "what is up, doc?";
#content = "hello";

puts "content:" + content;

header = "blob #{content.length}\0";

puts "header:" + header;

store = header + content;

puts "store:" + store;

require 'digest/sha1';

sha1 = Digest::SHA1.hexdigest(store);

puts "sha1:" + sha1;

require 'zlib';

zlib_content = Zlib::Deflate.deflate(store);

#puts "zlib_content:" + zlib_content;

path = '.git/objects/' + sha1[0,2] + '/' + sha1[2,38];

require 'fileutils';

FileUtils.mkdir_p(File.dirname(path));

File.open(path, 'w') { |f| f.write zlib_content };

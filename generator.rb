#!/usr/bin/env ruby

list = File.readlines("list.csv")

contacts = list.map(&:chomp).map {|l| l.split(",") }.sort_by {|c| c[0] }

vcard = <<-VCARD
BEGIN:VCARD
VERSION:3.0
PRODID:-//Apple Inc.//iPhone OS 11.0//EN
N:;SPAM;;;
FN: SPAM
VCARD

contacts.each_with_index do |contact, index|
vcard += <<-VCARD
item#{index+1}.TEL:#{contact[0]}
item#{index+1}.X-ABLabel:#{contact[0]} - #{contact[1]}
VCARD
end

vcard += <<-VCARD
END:VCARD
VCARD

filename = "spam_contacts.vcf"

File.write(filename, vcard)

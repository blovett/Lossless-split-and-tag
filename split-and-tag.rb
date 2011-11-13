#!/usr/bin/env ruby

#
# ----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <ben@biggiantnerds.com> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return.
#    - Ben Lovett
# ----------------------------------------------------------------------------
#

require 'optparse'

options = {:cue_file	=> nil,
	   :src_file	=> nil,}

opt = OptionParser.new
opt.on("--cue FILE", "CUE file") do |f|
	options[:cue_file] = f
end

opt.on("--src FILE", "Source file") do |f|
	options[:src_file] = f
end

opt.parse!

[:cue_file, :src_file].each {|v| raise "#{v} should be supplied" unless options[v]}
cmd = "shntool split -f \"#{options[:cue_file]}\" -o flac \"#{options[:src_file]}\""
system(cmd)

count = `cueprint -d '%N\n' \"#{options[:cue_file]}\"`.to_i

def get_and_set_tags(cue_file, flac_file, num)
	formats = Hash.new
	formats[:title] = "%t"
	formats[:album] = "%T"
	formats[:tracknumber] = "%n"
	formats[:tracktotal] = "%N"
	formats[:artist] = "%c %p"
	formats[:performer] = "%p"
	formats[:description] = "%m"
	formats[:genre] = "%g"
	formats[:isrc] = "%i %u"

	values = Hash.new
	formats.each_pair do |k,v|
		cmd = "cueprint -n #{num} -t \"#{formats[k]}\" \"#{cue_file}\""
		values[k] = `#{cmd}`
	end

	formats.each_pair do |k,v|
		tag_val = "#{k.to_s.upcase}=#{values[k]}"
		set_cmd = "metaflac --preserve-modtime --set-tag=\"#{tag_val}\" #{flac_file}"
		system(set_cmd)
	end
end

(1..count).each do |n|
	filename = "split-track"
	if (count < 100)
		filename = filename + "%02d.flac" % n
	else
		filename = filename + "%03d.flac" % n
	end

	get_and_set_tags(options[:cue_file], filename, n)
end

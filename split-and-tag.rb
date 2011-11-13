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
	# Remove any/all tags before we start
	cmd = "metaflac --remove-all-tags #{flac_file}"
	system(cmd)

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

	# We didn't get a genre?
	if values[:genre].empty?
		# maybe it's defined as a comment?
		tmp = File.read(cue_file).scan(/^REM GENRE\s*(\w*)/).to_s
		if !tmp.empty?
			values[:genre] = tmp
		end
	end

	# Album year
	tmp = File.read(cue_file).scan(/^REM DATE\s*(\d*)/).to_s
	if !tmp.empty?
		values[:date] = tmp
	end

	values.each_pair do |k,v|
		tag_val = "#{k.to_s.upcase}=#{values[k]}"
		set_cmd = "metaflac --preserve-modtime --set-tag=\"#{tag_val}\" #{flac_file}"
		system(set_cmd)
	end
end

def rename_file(file)
	track_num = file.scan(/(\d+)/)
	title = `metaflac --show-tag=TITLE #{file}`.chomp.split(/=/)[1]
	title.gsub!(" ", "_")
	new_file = "#{track_num}-#{title}" + ".flac"

	begin
		print "Trying to rename #{file} to #{new_file} .."
		File.rename(file, new_file)
		print " done!\n"
	rescue => e
		print "\n"
		puts "We were unable to rename #{file}. The error was: #{e}"
		puts "Sorry about that."
	end

end

(1..count).each do |n|
	split_filename = "split-track"
	if (count < 100)
		split_filename = split_filename + "%02d.flac" % n
	else
		split_filename = split_filename + "%03d.flac" % n
	end

	get_and_set_tags(options[:cue_file], split_filename, n)
	rename_file(split_filename)
end

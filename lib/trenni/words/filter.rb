# Copyright, 2016, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module Trenni
	module Words
		# Filters patterns from a block of text.
		class Filter
			def initialize(patterns)
				@patterns = Regexp.union(*patterns)
			end
			
			def replace(match)
				'*' * match.length
			end
			
			def apply(text)
				text.gsub(@patterns, &self.method(:replace))
			end
			
			def =~ text
				@patterns =~ text
			end
			
			# Convert a string into a regexp. If the string starts with a `/`, it's considered a raw regexp.
			def self.regexp_from_wildcard(string)
				if string.start_with? '/'
					return Regexp.new(string[1...-1], Regexp::IGNORECASE)
				else
					return Regexp.new('\b' + string + '\b', Regexp::IGNORECASE)
				end
			end
			
			def self.load_file(path)
				patterns = File.readlines(path).collect do |line|
					self.regexp_from_wildcard(line.chomp!)
				end
				
				Filter.new(patterns)
			end
			
			def self.for_obscenity
				@obscenity_filter ||= self.load_file(File.expand_path("obscenity.txt", __dir__))
			end
		end
	end
end

# * Name: ModelFetch
# * Description: Fetch a model based on its primary key or by an existing instance of it.
# *   This version supports "ghosted" instances for use with a cache server by
# *   using the primary key of an existing model that is passed in.
#
# * Other Details:
# *   Null values are supported and return a null object
# *   You can send a string scope to include with the search.
#
# * Requirements: Rails 3+
#
# License: MIT
# Copyright (c) 2012 Scott Croneberger
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module ModelFetch
    def self.included(base) # :nodoc:
      base.extend ClassMethods
    end
    
		module ClassMethods
		  def model_fetch(input, scopes=nil)
		    do_model_fetch(input, scopes)
	    end
	    
			protected
			def do_model_fetch(input_parameter, injected_scopes=nil)
			  klass = self			  
			  input_parameter_id = case input_parameter
			  when Integer
			    input_parameter
		    when klass
		      eval("input_parameter.#{klass.primary_key}")
	      when nil
	        nil
	      else
	        eval("klass.find(input_parameter).#{klass.primary_key}")
			  end		  
			  unless input_parameter_id.nil?
          str = injected_scopes.nil? ? "klass" : "klass.#{injected_scopes}"
          str = str + ".where(:#{klass.primary_key} => input_parameter_id)"
			    eval(str)
		    else
		      nil
	      end
			end	# end do_model_fetch	
		end # end ClassMethods
end # end ModelFetch

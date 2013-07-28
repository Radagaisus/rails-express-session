require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ExpressSession" do
  
  describe "ExpressCookieSignature" do

  	describe 'Express::Cookie.sign(val, secret)' do

	  	it 'should sign the cookie' do
	  		val = Express::CookieSignature.sign 'hello', 'tobiiscool'
	  		val.should eq 'hello.kVofCuivbz8r8NiCfWJV5JsZQBX6WGHgt8ihyKktT7OdEObssUD5JItXNDH9PIaD+rTEQTK9V6+prF9qR0aDSg'

	  		val = Express::CookieSignature.sign 'hello', 'luna'
	    	val.should_not eq 'hello.kVofCuivbz8r8NiCfWJV5JsZQBX6WGHgt8ihyKktT7OdEObssUD5JItXNDH9PIaD+rTEQTK9V6+prF9qR0aDSg'
	  	end

	  end

	  describe 'Express::Cookie.unsign(val, secret)' do
  		
  		it 'should unsign the cookie' do
  			val = Express::CookieSignature.sign 'hello', 'tobiiscool'
  			Express::CookieSignature
  				.unsign(val, 'tobiiscool').should eq 'hello'
  			Express::CookieSignature.unsign(val, 'luna').should eq false
  		end

  	end
  end
end

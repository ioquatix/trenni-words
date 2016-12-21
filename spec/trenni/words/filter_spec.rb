
require 'trenni/words/filter'

RSpec.describe Trenni::Words::Filter do
	subject {Trenni::Words::Filter.for_obscenity}
	
	it "should filter bad words" do
		text = subject.apply("you are a major cuntfucker ass")
		
		expect(text).to_not include 'cunt'
		expect(text).to_not include 'fuck'
		expect(text).to_not include 'ass'
	end
	
	it "should filter acceptable words" do
		text = subject.apply("you sexist bastard")
		
		expect(text).to include 'sexist'
	end
end

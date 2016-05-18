FactoryGirl.define do
	factory :play do

		title 'A Midsummer Night\'s Dream'
		date '1599-01-01'
		author
		
		#script ActionDispatch::Http::UploadedFile.new(:tempfile => File.new("#{Rails.root}/spec/data/test_script.html"), :filename => "test_script.html")
	end
end
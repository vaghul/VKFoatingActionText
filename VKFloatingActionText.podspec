#
#  Be sure to run `pod spec lint VKFloatingActionText.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|



  s.name         = "VKFloatingActionText"
  s.version      = "0.1.0"
  s.summary      = "VKFloatingActionText Field Menu Control."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC"A Floating TextField Menu For List of Input https://www.cocoacontrols.com/controls/vkfoatingactiontext"
                   DESC

  s.homepage     = "https://github.com/vaghul/VKFoatingActionText"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "vaghul" => "vaghulk@gmail.com" }
  # Or just: s.author    = "vaghul"
  # s.authors            = { "vaghul" => "" }
   s.social_media_url   = "https://twitter.com/vaghulk"
  s.source       = { :git => "https://github.com/vaghul/VKFoatingActionText.git", :tag => s.version.to_s }

s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'Pods/Classes/**/*'

end

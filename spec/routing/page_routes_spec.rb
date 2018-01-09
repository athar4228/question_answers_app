require "rails_helper"

RSpec.describe "routes to the pages controller", :type => :routing do
  it "routes a named route" do
    expect(:get => '/'). to route_to(controller: 'pages', action: "home")
  end
end

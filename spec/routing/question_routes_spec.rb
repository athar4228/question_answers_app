require "rails_helper"

RSpec.describe "routes to the questions controller", type: :routing do
  subject { create(:question) }
  it "routes a named route" do
    expect(:get => '/questions'). to route_to(controller: 'questions', action: "index")
    expect(:get => '/questions/1'). to route_to(controller: 'questions', action: "show", id: "1")
    expect(:post => '/questions'). to route_to(controller: 'questions', action: "create")
    expect(:patch => '/questions/1'). to route_to(controller: 'questions', action: "update", id: "1")
    expect(:delete => '/questions/1'). to route_to(controller: 'questions', action: "destroy", id: "1")
  end
end

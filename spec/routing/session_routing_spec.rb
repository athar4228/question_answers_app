require "rails_helper"

RSpec.describe "routes to the sessions controller", type: :routing do
  it "routes a named route" do
    expect(get: 'auth/google/callback'). to route_to(controller: 'sessions', action: "create", provider: "google")
    expect(get: 'logout'). to route_to(controller: 'sessions', action: "destroy")
  end
end

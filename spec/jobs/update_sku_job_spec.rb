require 'rails_helper'

RSpec.describe UpdateSkuJob, type: :job do
  let(:book_title) { "book name" }

  before do
    # this line mocks the request
    allow(Net::HTTP).to receive(:start).and_return(true)
  end

  it "calls SKU service with correct params" do
    expect_any_instance_of(Net::HTTP::Post).to receive(:body=).with(
      { sku: "123", title: book_title }.to_json
    )

    described_class.perform_now("book name")
  end
end

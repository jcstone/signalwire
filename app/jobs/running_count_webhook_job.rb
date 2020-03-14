class RunningCountWebhookJob < ApplicationJob
  queue_as :default

  def perform(tag)
    url = URI.parse('https://webhook.site/37fdc334-e4d3-4ad1-8abf-1e0743d8599c')
    http = Net::HTTP.new(url.host)
    http.post(url, tag.to_json, {"Content-Type" => "application/json", "Accept" => "application/json"})
  end
end

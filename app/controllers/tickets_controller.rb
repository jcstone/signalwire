class TicketsController < ApplicationController
  require 'net/http'
  # POST /tickets
  def create
    params["ticket"]["all_tags"] = params["tags"]
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      post_running_count(Tag.highest_running_count)
      render json: @ticket, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def ticket_params
      params.require(:ticket).permit(:title, :user_id, all_tags: [])
    end

    def post_running_count tag
      url = URI.parse('https://webhook.site/37fdc334-e4d3-4ad1-8abf-1e0743d8599c')
      http = Net::HTTP.new(url.host)
      http.post(url, tag.to_json, {"Content-Type" => "application/json", "Accept" => "application/json"})
      # response = http.request(request)
    end
end

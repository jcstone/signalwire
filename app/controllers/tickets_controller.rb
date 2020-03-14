class TicketsController < ApplicationController
  # POST /tickets
  def create
    params["ticket"]["all_tags"] = params["tags"]
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      RunningCountWebhookJob.perform_later Tag.highest_running_count
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
end

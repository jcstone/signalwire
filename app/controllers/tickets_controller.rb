class TicketsController < ApplicationController

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      params["tags"].each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name.downcase)
        tag.increment!(:running_count, 1).save
        @ticket.taggings.new(tag_id: tag.id).save
      end
      render json: @ticket, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def ticket_params
      params.require(:ticket).permit(:title, :user_id)
    end
end

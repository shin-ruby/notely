module Api
  module V1
    class NotesController < ApplicationController
      before_action :set_note, only: [:show, :update, :destroy]

      before_action -> { doorkeeper_authorize! :public }, only: :index
      before_action only: [:create, :update, :destroy] do
        doorkeeper_authorize! :write, :update
      end

      # GET /notes
      def index
        @notes = Note.all

        render json: @notes
      end

      # GET /notes/1
      def show
        render json: @note
      end

      # POST /notes
      def create
        @note = Note.new(note_params)

        if @note.save
          render json: @note, status: :created, location: @note
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /notes/1
      def update
        if @note.update(note_params)
          render json: @note
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      # DELETE /notes/1
      def destroy
        @note.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_note
          @note = Note.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def note_params
          params.require(:note).permit(:title, :body, :category_id)
        end
    end
  end
end

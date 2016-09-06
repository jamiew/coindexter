class CommentsController < ApplicationController
    
    before_action :find_commentable
    before_action :authenticate_user!, only: [:edit,:new,:create,:update]

    def new
      @comment = current_user.comments.new
      respond_to do |format|
        format.html
        format.js
        format.json
      end
    end

    def create
      @comment = @commentable.comments.new comment_params
      @comment.user = current_user
      if @comment.save
        redirect_to :back
      else
        redirect_to :back, notice: "There was an error posting your comment"
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Link.friendly.find(params[:link_id]) if params[:link_id]
    end

end

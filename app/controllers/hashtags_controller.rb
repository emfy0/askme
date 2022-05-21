class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.with_questions.friendly.find(params[:id])
    @questions = @hashtag.questions.includes(%i[user author hashtag_linkers hashtags])
  end
end

class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.friendly.find(params[:id])
    @questions = @hashtag.questions
                         .includes([:user])
                         .includes([:author])
                         .includes([:hashtag_linkers])
                         .includes([:hashtags])
  end
end

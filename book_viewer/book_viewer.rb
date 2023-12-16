require "sinatra"
require "sinatra/reloader" if development?
require "tilt/erubis"

before do
  @contents = File.readlines("data/toc.txt")
end

helpers do
  def in_paragraphs(text)
    number = 0
    text.split("\n\n").map do |parag|
      number += 1
      "<p id=#{number}>#{parag}</p>"
    end.join
  end

  def strong_wrap(text, query)
    text.gsub(query, "<strong>#{query}</strong>")
  end

  def each_chapter
    @contents.each_with_index do |name, index|
      number = index + 1
      contents = File.read("data/chp#{number}.txt")
      yield number, name, contents
    end
  end

  def each_paragraph(contents, query)
    paragraph_info = []
    paragraphs = contents.split("\n\n")
    paragraphs.each_with_index do |paragraph, idx|
      if paragraph.include?(query)
        paragraph_info << {number: (idx + 1), content: paragraph}
      end
    end
    paragraph_info
  end

  def chapters_matching(query)
    results = []

    return results if !query || query.empty?

    each_chapter do |number, name, contents|
      if contents.include?(query)
        results << {number: number, name: name, paragraph_info: each_paragraph(contents, query)}
      end
    end

    results
  end
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  erb :home
end

get "/chapters/:number" do
  @chapter_number = params[:number].to_i
  redirect "/" unless @chapter_number <= @contents.size
  @title = @contents[@chapter_number - 1]
  @chapter = File.read("data/chp#{@chapter_number}.txt")
  erb :chapter
end

get "/search" do
  @results = chapters_matching(params[:query])
  erb :search
end

not_found do
  redirect "/"
end


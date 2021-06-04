namespace :blm do
  task books_with_authors: :environment do
    path = Dir.glob('db/labirint.json').first
    file = File.read(path)
    data = JSON.load(file)
    data.each do |h|
      unless h["authors"].nil?
        h["authors"].each do |author|
          Author.create(name: author)
          puts "#{author} - author created"
        end
      end
      book = Book.new(title: h["title"], series: h["series"], lb_id: h["lb_id"], isbn: h["isbn"], poster: h["poster"])
      unless h["authors"].nil?
        h["authors"].each do |author|
          book.authors << Author.find_by(name: author)
          puts "author #{author} add to book #{h["title"]}"
        end
      end
      book.save
      puts "book #{h["title"]} created"
    end
  end
end

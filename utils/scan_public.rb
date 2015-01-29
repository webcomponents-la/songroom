require 'bundler'
require 'pathname'
require 'json'
require 'active_support/core_ext'
require 'firebase'
require 'digest/sha1'

Bundler.require :default
Dotenv.load

$firebase = firebase = Firebase::Client.new(ENV['FIREBASE_ORIGIN'], ENV['FIREBASE_TOKEN'])

def clean_artist(artist)
  artist.split(", ").reverse.join(" ").downcase.gsub(/[^a-z0-9 -]/,'')
end

def clean_title(title)
  title.sub(/, the\z/i,"").downcase.gsub(/[^a-z0-9 -]/,'')
end

begin
  songs = {}
  s3 = AWS::S3.new(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
  s3.buckets['songroom'].objects.with_prefix('songs/karaoke/Public Domain').each do |obj|
    next unless obj.key.end_with? '.mp3'
    path = Pathname.new(obj.key)
    filename = path.basename.to_s.sub!(/\.mp3\z/,'')
    title = filename.split(' ')[1..-1].join(' ').split(' - ').first
    songs[Digest::SHA1.hexdigest(obj.key)] = {
      title: title,
      artist: 'Standard',
      mp3_url: obj.public_url(secure: true).to_s,
      cdg_url: obj.public_url(secure: true).to_s.sub('.mp3', '.cdg')
    }
  end
rescue StandardError => e
  raise e
ensure
  File.open('../fixtures/collections/pub.json', 'w').write({songs: songs}.to_json)
end
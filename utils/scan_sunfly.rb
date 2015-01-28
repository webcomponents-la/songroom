require 'bundler'
require 'pathname'
require 'json'
require 'active_support/core_ext'
require 'echonest-ruby-api'
require 'firebase'

Bundler.require :default
Dotenv.load

$echonest = Echonest::Song.new(ENV['ECHONEST_KEY'])
$firebase = firebase = Firebase::Client.new(ENV['FIREBASE_ORIGIN'], ENV['FIREBASE_TOKEN'])


$processed = JSON.parse(File.read('processed.json')) rescue []

def clean_artist(artist)
  artist.split(", ").reverse.join(" ").downcase.gsub(/[^a-z0-9 -]/,'')
end

def clean_title(title)
  title.sub(/, the\z/i,"").downcase.gsub(/[^a-z0-9 -]/,'')
end

def process(obj)
  if $processed.include?(obj.key)
    puts ">>> Skipped #{obj.key}, already processed"
    return
  end

  if obj.key.end_with?('.mp3')
    path = Pathname.new(obj.key)
    filename = *path.basename.to_s.sub!(/\.mp3\z/,'')
    artist, title = filename.split(" - ")[1..2]

    unless artist && title
      puts "xxx ERROR: Couldn't parse '#{filename}'"
      return
    end

    result = $echonest.search(
      title: clean_title(title),
      artist: clean_artist(artist),
      bucket: %w(id:musicbrainz id:spotify song_hotttnesss song_currency tracks id:lyricfind-US),
      results: 1, song_type: 'studio', rank_type: 'familiarity'
    ).first

    if result
      record = {
        artist: result[:artist_name],
        artist_id: result[:artist_id],
        title: result[:title],
        hotness: result[:song_hotttnesss],
        currency: result[:song_currency],
        mp3_url: obj.public_url(secure: true).to_s,
        cdg_url: obj.public_url(secure: true).to_s.sub('.mp3', '.cdg')
      }

      result[:tracks].try(:each) do |track|
        if track[:catalog] == 'spotify'
          record[:spotify_track_id] = track[:foreign_id]
          record[:spotify_album_id] = track[:foreign_release_id]
        elsif track[:catalog] == 'lyricfind-US' && !record[:lyricfind_id]
          record[:lyricfind_id] = track[:foreign_id]
        end
      end

      result[:artist_foreign_ids].try(:each) do |artist|
        if artist[:catalog] == 'musicbrainz'
          record[:musicbrainz_artist_id] = artist[:foreign_id]
        elsif artist[:catalog] == 'spotify'
          record[:spotify_artist_id] = artist[:foreign_id]
        end
      end

      $firebase.update("collections/nDt72ghrlCdcWPWH0i2pfA/songs/#{result[:id]}", record)
      puts "+++ Found #{result[:artist_name]} - #{result[:title]}"
    else
      $firebase.push("collections/nDt72ghrlCdcWPWH0i2pfA/unidentified", {
        artist: artist,
        title: title,
        url: obj.public_url(secure: true).to_s,
        cdg_url: obj.public_url(secure: true).to_s.sub('.mp3', '.cdg')
      })
      puts "--- Couldn't find #{artist} - #{title}, added to unidentified"
    end
    $processed << obj.key
  end

rescue Echonest::Error => e
  puts "xxx ECHONEST ERROR: #{e.message}"
  sleep 10
  process(obj)
end

begin
  s3 = AWS::S3.new(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
  s3.buckets['songroom'].objects.with_prefix('songs/karaoke/Sunfly Karaoke').each do |obj|
    process(obj)
  end
rescue StandardError => e
  raise e
ensure
  File.open('processed.json', 'w').write($processed.to_json)
end
class SongUploader < Shrine
   plugin :validation_helpers

   Attacher.validate do
      validate_mime_type_inclusion %w[audio/wav audio/mp3]
  end

end

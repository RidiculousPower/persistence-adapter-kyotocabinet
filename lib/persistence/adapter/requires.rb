
basepath = 'kyotocabinet'

files = [
  
  'database_support',

  'bucket/index/index_interface',
  'bucket/index',

  'bucket/bucket_interface',
  'bucket',

  'cursor/cursor_interface',
  'cursor',

  'adapter_interface',

  'marshal',
  'yaml'
  
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end

require_relative( basepath + '.rb' )

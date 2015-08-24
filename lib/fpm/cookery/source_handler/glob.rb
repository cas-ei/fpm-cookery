require 'fpm/cookery/source_handler/template'
require 'fpm/cookery/log'
require 'fileutils'
require 'pry'

module FPM
  module Cookery
    class SourceHandler
      class Glob < FPM::Cookery::SourceHandler::Template
        CHECKSUM = false
        NAME = :glob

        def fetch(config = {})
          Dir.glob(source.path).each do |file| 
            cached_file = File.join(@cachedir,file)
            if File.exist? cached_file
              Log.info "Using cached file #{cached_file}"
            else
              Log.info "Copying #{file} to cache"
              FileUtils.cp_r(file, cachedir)
            end
          end
          local_path
        end

        def extract(config = {})
          Dir.chdir(builddir) do
            Dir.glob(local_path).each do |file| 
	    case File.extname file
            when '.bz2', '.gz', '.tgz', '.xz'
              safesystem('tar', 'xf', file)
            when '.shar', '.bin'
              File.chmod(0755, file)
              safesystem(file)
            when '.zip'
              safesystem('unzip', '-d', file.basename(file,'.zip'), file)
            else
              FileUtils.cp_r(file, builddir)  
            end
          end
          builddir
          end
        end
      end
    end
  end
end

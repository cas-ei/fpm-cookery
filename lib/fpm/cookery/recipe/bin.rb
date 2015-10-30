require 'pry'
module FPM
  module Cookery
    # Helps re-packaging binary installables
    class BinRecipe < Recipe

      def input(config)
        FPM::Cookery::Package::Dir.new(self, config)
      end

      # Binaries have no default build action.
      def build
      end

      # Default action for a binary install is to copy items selected
      def install
        FileUtils.cp_r File.join(builddir,'.'), destdir
        #Remove build cookie
        Dir.glob("#{destdir}/.build-cookie-*").each do |f| 
          puts "Deleting Build Cookie #{f}"
          File.delete(f) 
        end
      end
    end
  end
end

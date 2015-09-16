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
        puts "Build Dir #{builddir}"
        puts "Build Dir #{destdir}"
        FileUtils.cp_r File.join(builddir,'.'), destdir
      end
    end
  end
end

# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Cork < Formula
  desc "A boolean/CSG library supporting operations between triangle meshes."
  homepage "https://github.com/gilbo/cork"
  head "https://github.com/gilbo/cork.git"

  def install
    # replace the GMP paths with those of the current version.
    inreplace "makeConstants", /GMP_INC_DIR = (.*)/, "GMP_INC_DIR = " + Formula["gmp"].opt_include
    inreplace "makeConstants", /GMP_LIB_DIR = (.*)/, "GMP_LIB_DIR = " + Formula["gmp"].opt_lib 
    # build the package.
    make
    # copy the binaries into the package directory structure.
    include.install Dir["include/*"]
    bin.install Dir["bin/*"]
    lib.install Dir["lib/*"]
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test cork`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

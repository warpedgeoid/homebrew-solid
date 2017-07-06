# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Cork < Formula
  desc "A boolean/CSG library supporting operations between triangle meshes."
  homepage "https://github.com/gilbo/cork"
  url "https://github.com/libigl/cork.git", 
    :revision => "adf814edd555cb4245edf6f539eddb7880edf195"
  version "20160317"

  head "https://github.com/libigl/cork.git"

 depends_on "cmake" => :build

  def install
    inreplace "CMakeLists.txt", 
      "-DNO_TIMER -DREDUCED -DCDT_ONLY -DTRILIBRARY -DANSI_DECLARATORS )",
      "-DNO_TIMER -DREDUCED -DTRILIBRARY -DANSI_DECLARATORS )"
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      # build the package.
      system "make"

      bin.install "cork"
      lib.install "libcork.a"
    end
    include.install Dir.glob("src/**/*.h")
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

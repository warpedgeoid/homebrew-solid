# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Quartet < Formula
  desc "A tetrahedral mesh generator based on Jonathon Shewchuk's isosurface stuffing algorithm in combination with the A15 acute tetrahedral tile."
  homepage "https://github.com/crawforddoran/quartet"
  url "https://github.com/crawforddoran/quartet.git",
    :using => :git,
    :revision => "a99c049f918d11cc5f7b023ef161b144b198edb5"

  # set the version to the commit date for git-only upstream source without tags.
  version "20141018"

  # patch to fix Makefile for macOS build.
  patch :DATA

  def install
    system "make", "depend"
    system "make", "release"
    bin.install "quartet_release" => "quartet"
    bin.install "view_tet_release"=> "view_tet"
    lib.install "libquartet.a"
    include.install Dir["src/*.h"]
    doc.install Dir["meshes"]
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test quartet`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

__END__
diff --git a/Makefile b/Makefile
index 52bdd5a..7703dc8 100644
--- a/Makefile
+++ b/Makefile
@@ -23,6 +23,21 @@ SRC = predicates.cpp           \
       make_tet_mesh.cpp        \
       main.cpp
 
+LIB_NAME = libquartet.a
+LIB_SRC = predicates.cpp           \
+      geometry_queries.cpp     \
+      sdf.cpp                  \
+      trimesh.cpp              \
+      tet_mesh.cpp             \
+      feature.cpp              \
+      read_obj.cpp             \
+      tet_quality.cpp          \
+      match_features.cpp       \
+      optimize_tet_mesh.cpp    \
+      make_signed_distance.cpp \
+      make_tet_mesh.cpp
+
+
 VIEWER_PROGRAM = view_tet
 VIEWER_SRC = gluvi.cpp             \
              view_tet.cpp          \
@@ -36,12 +51,22 @@ VIEWER_SRC = gluvi.cpp             \
 
 SRC_ALL = $(SRC) $(VIEWER_SRC)
 
-include Makefile.defs
+#include Makefile.defs
+DEPEND = g++
+CC = g++ -Wall
+RELEASE_FLAGS = -O3 -DNDEBUG -funroll-loops
+DEBUG_FLAGS = -g
+LINK = g++
+LINK_LIBS = -lm
+AR_CMD = ar rcs
+VIEWER_LIBS = -framework OpenGL -framework GLUT
 
 # object files
 RELEASE_OBJ = $(patsubst %.cpp,obj/%.o,$(notdir $(SRC)))
+LIB_RELEASE_OBJ = $(patsubst %.cpp,obj/%.o,$(notdir $(LIB_SRC)))
 VIEWER_RELEASE_OBJ = $(patsubst %.cpp,obj/%.o,$(notdir $(VIEWER_SRC)))
 DEBUG_OBJ = $(patsubst %.cpp,obj_debug/%.o,$(notdir $(SRC)))
+LIB_DEBUG_OBJ = $(patsubst %.cpp,obj_debug/%.o,$(notdir $(LIB_SRC)))
 VIEWER_DEBUG_OBJ = $(patsubst %.cpp,obj_debug/%.o,$(notdir $(VIEWER_SRC)))
 
 .PHONY: all
@@ -63,6 +88,12 @@ $(VIEWER_PROGRAM): $(VIEWER_DEBUG_OBJ)
 $(VIEWER_PROGRAM)_release: $(VIEWER_RELEASE_OBJ)
 	$(LINK) $(RELEASE_LINKFLAGS) -o $@ $^ $(LINK_LIBS) $(VIEWER_LIBS)
 
+$(LIB_NAME)_release: $(LIB_RELEASE_OBJ)
+	$(AR_CMD) $(LIB_NAME) $(LIB_RELEASE_OBJ)
+
+$(LIB_NAME): $(LIB_RELEASE_OBJ)
+	$(AR_CMD) $(LIB_NAME) $(LIB_DEBUG_OBJ)
+
 # how to compile the predicates.cpp source file
 # This is different because optimization must be disabled 
 # (at least, according to the TetGen source... not sure if it's true or not)
@@ -73,10 +104,10 @@ obj_debug/predicates.o: src/predicates.cpp
 
 
 .PHONY: release
-release: $(MAIN_PROGRAM)_release $(VIEWER_PROGRAM)_release
+release: $(MAIN_PROGRAM)_release $(VIEWER_PROGRAM)_release $(LIB_NAME)_release
 
 .PHONY: debug
-debug: $(MAIN_PROGRAM) $(VIEWER_PROGRAM)
+debug: $(MAIN_PROGRAM) $(VIEWER_PROGRAM) $(LIB_NAME)
 
 # how to compile each file
 .SUFFIXES:
@@ -88,7 +119,7 @@ obj_debug/%.o:
 # cleaning up
 .PHONY: clean
 clean:
-	-rm -f obj/*.o $(MAIN_PROGRAM) $(VIEWER_PROGRAM) obj_debug/*.o $(MAIN_PROGRAM)_release $(VIEWER_PROGRAM)_release *core
+	-rm -rf obj $(MAIN_PROGRAM) $(VIEWER_PROGRAM) obj_debug $(MAIN_PROGRAM)_release $(VIEWER_PROGRAM)_release *core $(LIB_NAME)
 
 # dependencies are automatically generated
 .PHONY: depend

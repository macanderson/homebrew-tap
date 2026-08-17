# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.67 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.9.67"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.67/stella-0.9.67-aarch64-apple-darwin.tar.gz"
      sha256 "21fad5370d0f7f21b6fa4a85c5b417e3e623cf4197100155c73512952ce27a8e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.67/stella-0.9.67-x86_64-apple-darwin.tar.gz"
      sha256 "936449a84e6a22cacb4cf7b69f2ccb0a80bb9b045e54b83194dbc94d3988730b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.67/stella-0.9.67-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fe14dd40cbf9719fe7e22e5e6cbe015cca90e1877c8c881bb9fe84e1d8f98dcc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.67/stella-0.9.67-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8ce45c8f517352feb48ddc8ff556dde14c0c96b86fe1a515e680bbaba3ed944f"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.67 / @SHA_*@ placeholders below with
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
  version "0.6.67"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.67/stella-0.6.67-aarch64-apple-darwin.tar.gz"
      sha256 "f770cc195820f8e7cd1ef5942ea9898d58bf4a51ab8c30f743c03b6890c66e4a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.67/stella-0.6.67-x86_64-apple-darwin.tar.gz"
      sha256 "808f13ef33a4ce169bff06a03fee66bf073f706fdae866e3c9963f11e4b8eed2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.67/stella-0.6.67-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "493ff2090c9f6b8e60d9cba7bca631656291a43471b6551886fe3224233edc25"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.67/stella-0.6.67-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8348d19e8f56935cd36ececff1f7e87ae936996ec109ecfe6e6d254bb3233ab5"
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

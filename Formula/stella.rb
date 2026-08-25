# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.201 / @SHA_*@ placeholders below with
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
  version "0.9.201"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.201/stella-0.9.201-aarch64-apple-darwin.tar.gz"
      sha256 "25282661bb1d8f1e1d181aa1837d55f379c44c6f4f5689b2c78469da254e6cb3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.201/stella-0.9.201-x86_64-apple-darwin.tar.gz"
      sha256 "bc5da1174b1ae2301398874068dd4391be12beeb781e647cf2cc41232f26d552"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.201/stella-0.9.201-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cfe6e000f085cd66374167ea1494ecc055e3dba4866d2206f8c82464f1e6bb30"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.201/stella-0.9.201-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2576136215c45a9bbc180000cd7262d1aaa9442bf89f260fb7416562c6d000ee"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.157 / @SHA_*@ placeholders below with
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
  version "0.9.157"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.157/stella-0.9.157-aarch64-apple-darwin.tar.gz"
      sha256 "919935eff24713925f38153242e7f9837327f49b8cf181c152921a7ac72419d2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.157/stella-0.9.157-x86_64-apple-darwin.tar.gz"
      sha256 "ac3e0de4451c57f458ac23304b898d78f91b7f924aea34d3cd8a36f88ae29fbd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.157/stella-0.9.157-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "73c966879fc4c32dea4f4ba5d9fb6bf9de9d12811f590a2a727fc92c8a8ca71b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.157/stella-0.9.157-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d9085d49e152e6c581404d0d6e1ec693202029ece1660704c6d7baa2313720c7"
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

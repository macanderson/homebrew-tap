# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.444 / @SHA_*@ placeholders below with
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
  version "0.9.444"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.444/stella-0.9.444-aarch64-apple-darwin.tar.gz"
      sha256 "3c0e5124a13232f658770b099328572fdd2b5936552db8fdbd2d61ee1af08ef3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.444/stella-0.9.444-x86_64-apple-darwin.tar.gz"
      sha256 "08103d83b8dcf059573897e1cd0fa0c5cb9c6f12f80f24ac61030f0455e70020"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.444/stella-0.9.444-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "22f878676a1ab83d0fe6d8145c16ec5d620e2602f8dc5fb5681c692ed42b6822"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.444/stella-0.9.444-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "45e537636a00d5944b542f6a03487d31ff2921ce983935973a96da2469ae8639"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.216 / @SHA_*@ placeholders below with
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
  version "0.9.216"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.216/stella-0.9.216-aarch64-apple-darwin.tar.gz"
      sha256 "2c6faa52d64f9fc1e7456b5868abd7ab3c2f8dcc01c2a0e21682308cb6767bd5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.216/stella-0.9.216-x86_64-apple-darwin.tar.gz"
      sha256 "e783542c0834aa5cdcd1e86c47849ea30829acd8b1b72f68e193d6a427590b23"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.216/stella-0.9.216-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7e2a92588a783637ce78ce15deecf90655558f296020455db71235a9bd5318bd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.216/stella-0.9.216-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4dfb1ef56ddd0ceffa32a4fdf8dce9430b8b857093928f8a9af15099ba90600b"
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

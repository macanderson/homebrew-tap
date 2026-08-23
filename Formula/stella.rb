# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.166 / @SHA_*@ placeholders below with
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
  version "0.9.166"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.166/stella-0.9.166-aarch64-apple-darwin.tar.gz"
      sha256 "e2790ffae42318e6f4f2d1961e9d632be599ee6569f0879369cd4cd38ac172a7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.166/stella-0.9.166-x86_64-apple-darwin.tar.gz"
      sha256 "2b6bc00a47815bbf84fa54cf53c3fb0f9c17d88d106681d210a8e639835536af"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.166/stella-0.9.166-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ebba6ea560b0c1b1ef24ef9944019f371f55789f897e99bf2c35430d0d87f980"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.166/stella-0.9.166-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "77fcc99248344f24ba312b1b2643bcb57787a80ef5e4de989ca3c7a3a8b1ca09"
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

# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.58 / @SHA_*@ placeholders below with
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
  version "0.5.58"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.58/stella-0.5.58-aarch64-apple-darwin.tar.gz"
      sha256 "ef1426c238f5bb15432470eeb49746614846b348ac936b7a58889b1215af536d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.58/stella-0.5.58-x86_64-apple-darwin.tar.gz"
      sha256 "11db78f5de3f3001b3ff0346076f2933ed717e38972eb4eeffe0bdedef494955"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.58/stella-0.5.58-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4e763bca875bb099c56da6f41d2a07e070d2b16e2d0eabf51212953811bf2df5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.58/stella-0.5.58-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c3d38d174cdb64e3831ad661f49ef86f3c29c8482636974b2d0d36e4e0d056ee"
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

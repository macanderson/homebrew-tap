# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.219 / @SHA_*@ placeholders below with
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
  version "0.9.219"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.219/stella-0.9.219-aarch64-apple-darwin.tar.gz"
      sha256 "ff2dc84e276307a08c5de18d387610fcd4dd24827cf51de82da6a2a9e8b6ffed"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.219/stella-0.9.219-x86_64-apple-darwin.tar.gz"
      sha256 "6d5b76743da810941232873c1b7db56558416f1507a2b55cd80fb4a565367cf5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.219/stella-0.9.219-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e614eefda0a9ba361653e7cf3d64f14af0d2ef84f4c22d067fb4e5fded893635"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.219/stella-0.9.219-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "88e1cde4e4d96500c916f68468a66a2baca0e868b864c091e850f0ac6af53db4"
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

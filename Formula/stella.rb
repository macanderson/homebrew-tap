# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.43 / @SHA_*@ placeholders below with
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
  version "0.5.43"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.43/stella-0.5.43-aarch64-apple-darwin.tar.gz"
      sha256 "930a365f8d1e6dee2f48574efbf01337f7b8afe6555eda8c69e427897d61837c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.43/stella-0.5.43-x86_64-apple-darwin.tar.gz"
      sha256 "dd0e75cd3a56e843b00c51a1b2192fe062f6d5fc46d4b9b45f020abcaebe9d08"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.43/stella-0.5.43-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ab268c9af7fc7a304cde962f6347bdf9b221391924990491d1699bcb4a30eb58"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.43/stella-0.5.43-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "96c5037d6c04461454fb6c68a24e69f3879be73cef88f571b8a813a2d296cdb8"
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

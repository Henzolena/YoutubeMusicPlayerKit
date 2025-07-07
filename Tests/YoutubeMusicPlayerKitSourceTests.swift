import Foundation
import Testing
@testable import YoutubeMusicPlayerKit

struct YoutubeMusicPlayerKitSourceTests {
    
    @Test
    func identifiableConformance() throws {
        let id = UUID().uuidString
        #expect(YoutubeMusicPlayerKit.Source.video(id: id).id == id)
        #expect(YoutubeMusicPlayerKit.Source.videos(ids: [id, id]).id == "\(id),\(id)")
        #expect(YoutubeMusicPlayerKit.Source.playlist(id: id).id == id)
        #expect(YoutubeMusicPlayerKit.Source.channel(name: id).id == id)
    }
    
    @Test
    func arrayLiteralExpression() throws {
        let id = UUID().uuidString
        let source: YoutubeMusicPlayerKit.Source = [id]
        #expect(source == .videos(ids: [id]))
    }
    
    @Test
    func videoIDProperty() throws {
        let id = UUID().uuidString
        let source: YoutubeMusicPlayerKit.Source = .video(id: id)
        #expect(source.videoID == id)
        #expect(source.videoIDs == nil)
        #expect(source.playlistID == nil)
        #expect(source.channelName == nil)
    }
    
    @Test
    func videoIDsProperty() throws {
        let id = UUID().uuidString
        let source: YoutubeMusicPlayerKit.Source = .videos(ids: [id])
        #expect(source.videoID == nil)
        #expect(source.videoIDs == [id])
        #expect(source.playlistID == nil)
        #expect(source.channelName == nil)
    }
    
    @Test
    func playlistIDProperty() throws {
        let id = UUID().uuidString
        let source: YoutubeMusicPlayerKit.Source = .playlist(id: id)
        #expect(source.videoID == nil)
        #expect(source.videoIDs == nil)
        #expect(source.playlistID == id)
        #expect(source.channelName == nil)
    }
    
    @Test
    func channelNameProperty() throws {
        let id = UUID().uuidString
        let source: YoutubeMusicPlayerKit.Source = .channel(name: id)
        #expect(source.videoID == nil)
        #expect(source.videoIDs == nil)
        #expect(source.playlistID == nil)
        #expect(source.channelName == id)
    }
    
    @Test
    func videoURLGeneration() throws {
        let id = UUID().uuidString
        #expect(
            YoutubeMusicPlayerKit.Source.video(id: id).url?.absoluteString
            ==
            "https://www.youtube.com/watch?v=\(id)"
        )
        #expect(YoutubeMusicPlayerKit.Source.video(id: .init()).url == nil)
    }
    
    @Test
    func videosURLGeneration() throws {
        let id = UUID().uuidString
        #expect(
            YoutubeMusicPlayerKit.Source.videos(ids: [id, id]).url?.absoluteString
            ==
            "https://www.youtube.com/watch_videos?video_ids=\(id),\(id)"
        )
        #expect(YoutubeMusicPlayerKit.Source.videos(ids: .init()).url == nil)
    }
    
    @Test
    func playlistURLGeneration() throws {
        let id = UUID().uuidString
        #expect(
            YoutubeMusicPlayerKit.Source.playlist(id: id).url?.absoluteString
            ==
            "https://www.youtube.com/playlist?list=\(id)"
        )
        #expect(YoutubeMusicPlayerKit.Source.playlist(id: .init()).url == nil)
    }
    
    @Test
    func channelURLGeneration() throws {
        let id = UUID().uuidString
        #expect(
            YoutubeMusicPlayerKit.Source.channel(name: id).url?.absoluteString
            ==
            "https://www.youtube.com/@\(id)"
        )
        #expect(YoutubeMusicPlayerKit.Source.channel(name: .init()).url == nil)
    }
    
    @Test(
        arguments: [
            "https://youtu.be/VIDEO_ID",
            "https://www.youtube.com/watch?v=VIDEO_ID",
            "https://www.youtube.com/embed/VIDEO_ID",
            "https://www.youtube.com/shorts/VIDEO_ID",
            "https://www.youtube.com/live/VIDEO_ID",
            "https://www.youtube.com/v/VIDEO_ID",
            "https://www.youtube.com/e/VIDEO_ID"
        ]
    )
    func videoURLParsing(_ urlString: String) throws {
        #expect(YoutubeMusicPlayerKit.Source(urlString: urlString) == .video(id: "VIDEO_ID"))
    }
    
    @Test(
        arguments: [
            "https://www.youtube.com/watch_videos?video_ids=VIDEO_ID_1,VIDEO_ID_2"
        ]
    )
    func videosURLParsing(_ urlString: String) throws {
        #expect(
            YoutubeMusicPlayerKit.Source(urlString: urlString)
            ==
            .videos(ids: ["VIDEO_ID_1", "VIDEO_ID_2"])
        )
    }
    
    @Test(
        arguments: [
            "https://www.youtube.com/playlist?list=PLAYLIST_ID",
            "https://www.youtube.com/watch?v=abc&list=PLAYLIST_ID",
            "https://www.youtube.com/embed/videoseries?list=PLAYLIST_ID"
        ]
    )
    func playlistURLParsing(_ urlString: String) throws {
        #expect(YoutubeMusicPlayerKit.Source(urlString: urlString) == .playlist(id: "PLAYLIST_ID"))
    }
    
    @Test(
        arguments: [
            "https://www.youtube.com/channel/CHANNEL_NAME",
            "https://www.youtube.com/c/CHANNEL_NAME",
            "https://www.youtube.com/user/CHANNEL_NAME",
            "https://www.youtube.com/@CHANNEL_NAME",
            "https://www.youtube.com/feed/CHANNEL_NAME"
        ]
    )
    func channelURLParsing(_ urlString: String) throws {
        #expect(YoutubeMusicPlayerKit.Source(urlString: urlString) == .channel(name: "CHANNEL_NAME"))
    }
    
    @Test(
        arguments: [
            "https://www.youtube.com/watch",
            "https://www.youtube.com/watch?v=",
            "https://www.youtube.com/playlist?list=",
            "https://www.youtube.com/@",
            "not a url",
            ""
        ]
    )
    func invalidURLParsing(_ urlString: String) throws {
        #expect(YoutubeMusicPlayerKit.Source(urlString: urlString) == nil)
    }
    
}
